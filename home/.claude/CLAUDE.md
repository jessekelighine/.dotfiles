# Computing Environment Guide

This file describes the machines and tools available to you (Claude Code) when working for Jesse, how to use them, and the rules to follow. It applies to every project. Project-level `CLAUDE.md` files may add project-specific instructions; where they conflict with this file, ask Jesse.

---

## 1. Where am I running?

You may be running on either of two machines. Check with `hostname` before doing anything machine-specific.

| Hostname | Machine | Role |
|---|---|---|
| `sheepfold-2` | Jesse's MacBook (Apple M3, macOS) | Interactive work. May sleep, close, or change networks at any time. |
| `ovile` | Home workstation (Ubuntu Server 26.04 LTS) | Always-on compute box for long simulations and long-running agent work. |

A third resource, the Columbia HPC cluster **Insomnia**, is reachable only from the Mac (see §4).

### Choosing where to run a job

The Mac is fast (Apple M3: much faster per core than ovile, and slightly faster on short multi-core bursts), so **not everything should go to ovile**. Decide case by case:

| Situation | Run on | Why |
|---|---|---|
| Quick tests, debugging, small simulations that finish within a few minutes | **Mac** | Faster per core; no file syncing needed |
| Sustained all-core work expected to take **more than ~15 minutes** | **ovile** | The MacBook Air is fanless: sustained full load throttles, heats up, and drains the battery |
| Jesse wants to **close the laptop, travel, or let it sleep** while the job runs | **ovile** | Jobs on the Mac stop when it sleeps |
| Jesse needs the **Mac responsive** for other work (meetings, writing, teaching) while the job runs | **ovile** | Avoids slowing down the Mac |
| Job needs **lots of memory** (more than ~16 GB) | **ovile** | 32 GB vs 24 GB, and no competition with Mac apps |
| Large-scale parallel work beyond 12 threads / 32 GB RAM, or GPUs | **Insomnia** | Via Slurm, only from the Mac (see §4) |

How to apply this:
- **Estimate run time before choosing.** If unsure, run a short timing test locally (e.g. a few iterations or a reduced replication count) and extrapolate.
- **If the decision depends on Jesse's plans** (whether he will close the laptop, or needs the Mac for something else), ask him briefly instead of guessing.
- **Use both machines in parallel** when it helps: e.g. a long Monte Carlo on ovile while development and quick checks continue on the Mac.
- When already running on ovile itself, simply run locally there (still using detached tmux for anything long).
- Jobs on the Mac that may take more than a few minutes should also run in a way that survives terminal closure (e.g. tmux), and Jesse should be told they are running.

---

## 2. ovile (home workstation)

### Hardware
- Lenovo ThinkCentre M720s SFF
- Intel Core i7-8700: 6 cores / 12 threads, 3.2 GHz base, 4.6 GHz turbo
- 32 GB DDR4 RAM (~30 GiB usable) + 8 GB swap
- 512 GB NVMe SSD, `/` is ~466 GB
- Wired Ethernet only; always on; restarts automatically after a power cut
- Sustained full load on all 12 threads tops out around 75 °C, so long CPU-bound jobs are fine

### Access
- From the Mac: `ssh ovile` (over Tailscale, key-based auth, no password).
- SSH connection multiplexing is configured on the Mac (`ControlMaster auto`, `ControlPersist 4h`), so repeated `ssh ovile '<cmd>'` calls are fast (~0.04 s). Prefer many small, explicit remote commands over long interactive sessions.
- If `ssh ovile` fails from the Mac, the most likely cause is that the Tailscale app on the Mac is not running. Tell Jesse rather than trying to work around it. If an existing connection hangs, reset it with `ssh -O exit ovile`.
- User: `jessechen`. Home: `/home/jessechen`.

### Installed software
| Tool | Details |
|---|---|
| Python | 3.13 via **pyenv** (global). Use a per-project virtual environment (`uv venv` or `python -m venv`); do not `pip install` into the global interpreter. `uv` is installed. |
| R | Installed with **rig**. Packages install as Linux binaries from Posit Public Package Manager, so installs are fast. `pak` is available and resolves system dependencies. |
| LaTeX | **TeX Live 2025 (texlive-full, Debian packaging)** with `latexmk`, `pdflatex`, `xelatex`, `lualatex`, `biber`. Essentially every CTAN package is already installed. `tlmgr` does **not** work with this install; if a package seems missing, ask Jesse. |
| Editor | Neovim 0.12 (manually installed in `/opt/nvim-linux-x86_64`, linked from `~/.local/bin/nvim`) |
| Build tools | `build-essential` (gcc, make), `tree-sitter` CLI, `git` |
| Monitoring | `top`, `free -h`, `df -h`, `uptime`, `sensors` (CPU temperature), `stress-ng` |
| Session manager | `tmux` (Jesse's prefix on ovile is `Ctrl+a`) |
| Zotero | `zotkit` (see §5) |
| Claude Code | Installed natively in `~/.local/bin/claude`, auto-updates |

Note Ubuntu naming differences: `fd` is `fdfind` and `bat` is `batcat` (symlinks may exist in `~/.local/bin`).

### Running long jobs on ovile — REQUIRED pattern
Never run a long job as a plain foreground command over SSH. If the SSH connection drops (laptop sleeps, network changes), the job is killed.

Always launch long jobs in a **detached tmux session**, redirecting all output to a log file:

```bash
# From the Mac:
ssh ovile 'cd ~/projects/<project> && tmux new -d -s <session-name> "<command> > logs/<session-name>.log 2>&1"'

# When already running on ovile:
tmux new -d -s <session-name> "<command> > logs/<session-name>.log 2>&1"
```

- Use short, descriptive session names, e.g. `sar-mc-n500`.
- Create the `logs/` directory first if it does not exist.
- Check status: `tmux ls`, `tail -n 50 logs/<session-name>.log`.
- Never kill a tmux session you did not start; ask Jesse first.
- After launching, report to Jesse: the session name, the exact command, the log path, and the expected run time.

### Parallelism and resource etiquette
- ovile has 12 hardware threads. Use **at most 10 worker processes** by default, so that the system and Jesse's interactive sessions stay responsive. Use all 12 only if Jesse asks.
- When parallelizing across processes (multiprocessing, `parallel::mclapply`, `future`, joblib, multiple MCMC chains), **pin linear-algebra libraries to one thread per process** to avoid oversubscription:
  ```bash
  export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1
  ```
- Check memory before launching memory-heavy jobs (`free -h`). Keep total usage comfortably below ~28 GB; swapping makes everything crawl.
- Check disk before writing large outputs (`df -h /`). Save draws/results in compressed formats where reasonable.
- Before starting a new heavy job, check whether something is already running (`tmux ls`, `top -bn1 | head -20`) and do not start a competing heavy job without asking.

---

## 3. Moving files between the Mac and ovile

- **Code**: use git. Commit and push from one machine, pull on the other. Do not copy code with `scp` as the primary workflow.
- **Results and data**: use `rsync` (run on the Mac):
  ```bash
  rsync -avz ovile:~/projects/<project>/output/ ./output/      # ovile → Mac
  rsync -avz ./data/ ovile:~/projects/<project>/data/          # Mac → ovile
  ```
  Mind the trailing slash: `dir/` copies the contents, `dir` copies the directory itself.
- **Single files**: `scp file ovile:~/path/` or `scp ovile:~/path/file .`
- Never commit large data files, simulation output, or PDFs to git. Add them to `.gitignore`.

---

## 4. Insomnia (Columbia HPC)

### Access constraints — read carefully
- Insomnia requires the **Columbia Cisco VPN plus Duo two-factor approval on Jesse's phone**. You cannot complete Duo yourself.
- Insomnia is reachable **only from the Mac** while the VPN is connected. **ovile cannot reach Insomnia** (tested: port 22 times out). Do not try to connect to Insomnia from ovile.
- The Mac's `~/.ssh/config` defines:
  ```
  Host insomnia
      HostName insomnia.rcs.columbia.edu
      User cc5229
      ControlMaster auto
      ControlPath ~/.ssh/insomnia-codex.sock
      ControlPersist 8h
      ServerAliveInterval 60
      ServerAliveCountMax 3
  ```
- Jesse opens the master connection himself (`ssh insomnia` + Duo). You then reuse it:
  ```bash
  ssh -O check insomnia        # first, confirm "Master running"
  ssh insomnia '<command>'     # reuses the master connection, no Duo prompt
  ```
- **If `ssh -O check insomnia` does not report a running master, stop and ask Jesse to reconnect.** Do not start an `ssh insomnia` that would trigger a Duo prompt, and do not retry in a loop.
- The master typically dies when the VPN drops, the Mac sleeps, or the network changes.

### Login node policy — STRICT

Every `ssh insomnia '<command>'` runs on a **shared login node**. The cluster's own login banner states:

> Running processes longer than a few seconds and/or involving more than one core is STRICTLY FORBIDDEN on this node. Users who break the above rule abuse this shared resource, cause delays for other cluster users, end up on our watch list - and eventually will get penalized.

You are acting under **Jesse's personal account (`cc5229`)**. Any violation you cause is recorded against him and can lead to penalties for him. Treat this as a hard rule, not a guideline. When in doubt, do not run it on the login node.

#### ALLOWED directly on the login node
Only quick, single-core commands that finish in about a second:

| Category | Commands |
|---|---|
| Looking around | `ls`, `pwd`, `cat`, `head`, `tail`, `wc -l` (on small files), `stat`, `file` |
| Small file management | `mkdir`, `mv`, `rm` (specific files you created), `cp` of small files, `touch`, `ln` |
| Editing | writing or editing scripts and small text files |
| Version control | `git status`, `git log`, `git diff`, `git pull`, `git add`, `git commit`, `git push` (normal-sized repos) |
| Slurm control | `sbatch`, `squeue`, `sacct`, `sinfo`, `scancel` (own jobs only), `scontrol show job <id>` |
| Light inspection | `module avail`, `module list`, `which`, `echo $VAR`, `quota`/`df -h` on your own dirs |

#### FORBIDDEN on the login node (run through Slurm instead)
- Running **any** analysis or test code: `python script.py`, `Rscript`, `julia`, `matlab`, `pytest`, `testthat`, Stata, "just a quick check that it runs", notebooks
- **Installing or building**: `pip install` / `uv pip install` / `conda create` / `conda install` / `mamba`, R `install.packages()` / `pak::pkg_install()`, `make`, `cmake`, compiling C/C++/Fortran
- **Anything that may use more than one core**: parallel code, multithreaded BLAS, `make -j`, `xargs -P`, `parallel`
- **Heavy I/O or scans**: `tar`/`zip`/`gzip` of large files or directories, `find`/`du`/`grep -r` over large directory trees, `rsync` of many files between directories on the cluster
- **Long-running or interactive processes**: `watch`, `top`/`htop` left open, `sleep` loops, polling `squeue` in a tight loop (check at most once every few minutes)
- Starting editors, IDEs, Jupyter, or language servers on the login node

If a task is not clearly on the ALLOWED list, treat it as FORBIDDEN.

#### How to run things instead
- **Short one-off work** (a quick test, a small install, a compile) — run it on a compute node with `srun`; it returns when done:
  ```bash
  ssh insomnia 'cd ~/<project> && srun --time=00:10:00 --cpus-per-task=1 --mem=4G <command>'
  ```
- **Real jobs** — write an sbatch script and submit it:
  ```bash
  ssh insomnia 'cd ~/<project> && sbatch <script>.sbatch'
  ssh insomnia 'squeue -u cc5229'
  ssh insomnia 'sacct -u cc5229 --starttime today --format=JobID,JobName,State,Elapsed,MaxRSS'
  ```
- Always request explicit, modest resources (`--time`, `--cpus-per-task`, `--mem`). Do not request whole nodes, GPUs, or long wall times unless the task needs them and Jesse agrees.
- **Partition and account names are cluster-specific and are not recorded here.** Copy them from an existing sbatch script in the project or ask Jesse. Never guess; a wrong guess wastes queue time or fails. If `srun`/`sbatch` fails because a partition or account is required, stop and ask.
- Only cancel (`scancel`) jobs you submitted in this session, or jobs Jesse explicitly names.
- Never submit large job arrays or many jobs at once without Jesse's approval.

#### File transfer
- Transfer files between the Mac and Insomnia with `rsync`/`scp` using the `insomnia:` alias (only while the master connection is up). Transfers initiated from the Mac are fine.
- Do not bundle or compress large directories on the login node to make transfers easier; transfer directly with `rsync -avz` instead.

---

## 5. Zotero library (zotkit)

Jesse's Zotero library (~1,250 items, synced via zotero.org with PDFs in Zotero Storage) is available on **ovile** through the `zotkit` CLI. The zotkit skill is installed at `~/.claude/skills/zotkit/`; follow it for detailed usage.

- The API key is **read-only**. Searching, viewing, downloading PDFs, and exporting BibTeX work. Creating items, tagging, moving, and enriching will fail. Do not attempt write operations; if Jesse wants changes to the library, tell him what you would change and let him do it.
- Common commands:
  ```bash
  zotkit find --any <author-lastname-or-term>   # most reliable existence check: author last name
  zotkit find --title "<words>"
  zotkit show <ITEMKEY> [--json]
  zotkit fetch --key <ITEMKEY> --out ~/zotero-pdfs   # download attachments
  zotkit export --key <KEY1> <KEY2> -o refs.bib      # BibTeX, cite key = Zotero item key
  ```
- `zotkit fetch` defaults to `./downloads`. Always pass `--out` to a directory **outside** any git repository (e.g. `~/zotero-pdfs`), or make sure `downloads/` is in `.gitignore`. Never commit PDFs.
- A zero-hit search on a concept term does not prove the library lacks a paper on that topic; abstracts can be incomplete. Search by author last name before concluding something is missing.
- The configuration file contains the API key. Never print, copy, log, or commit it.

---

## 6. General rules and guardrails

**System administration**
- Do not run `sudo` commands without asking Jesse first. (sudo requires his password anyway.) Propose the exact command and why.
- Do not modify SSH server settings (`/etc/ssh/`), Tailscale, network configuration, firewall rules, or BIOS-related settings.
- **Never run `shutdown` or `poweroff` on ovile.** It cannot be powered back on remotely. A `reboot` is recoverable but still requires Jesse's approval first, and it kills all running tmux jobs.
- Do not install system packages (`apt`) without approval. User-level installs inside a project environment (Python venv, R project library) are fine.

**Secrets**
- Never print, echo, log, or commit API keys, tokens, or passwords. This includes `~/.config/zotkit/env` and anything under `~/.ssh/`.
- Dotfiles live in `~/.dotfiles` (managed with GNU stow) and may be pushed to GitHub. Never put secrets there.

**Git and files**
- Keep code in git; keep data, outputs, logs, and PDFs out of git.
- Do not delete data, results, or logs you did not create in this session without asking.

**Communication**
- When you launch anything long-running (on ovile or Insomnia), tell Jesse: where it runs, how to check on it, where the output goes, and roughly how long it should take.
- If a resource is unavailable (Tailscale down, VPN not connected, no Insomnia master socket), say so plainly and stop rather than improvising a workaround.

---

## 7. Quick troubleshooting

| Symptom | Likely cause | What to do |
|---|---|---|
| `ssh ovile` fails or hangs (from Mac) | Tailscale app not running on Mac, or stale master socket | Tell Jesse; try `ssh -O exit ovile` once, then retry |
| `ssh insomnia` prompts for password/Duo | No master connection | Stop and ask Jesse to run `ssh insomnia` himself |
| Insomnia unreachable entirely | Cisco VPN not connected | Ask Jesse to connect the VPN |
| Need to test/install/compile something on Insomnia | Login node forbids it | Use `srun` (see §4); never run it on the login node |
| `srun`/`sbatch` complains about partition or account | Cluster-specific settings unknown | Stop and ask Jesse; do not guess |
| Job on ovile died when the laptop slept | It was not run in detached tmux | Relaunch with the tmux pattern in §2 |
| Parallel job is much slower than expected | BLAS/OpenMP oversubscription | Set `OMP_NUM_THREADS=1` etc. (see §2) |
| `scp`/`rsync` to ovile fails with odd protocol errors | Something in `~/.bashrc` prints output in non-interactive shells | Check `~/.bashrc` on ovile; it must exit early for non-interactive shells |
| LaTeX package not found on ovile | Very rare with texlive-full; `tlmgr` unavailable | Ask Jesse |
