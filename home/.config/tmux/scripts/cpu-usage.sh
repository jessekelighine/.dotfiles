#!/usr/bin/env bash
# CPU usage for the tmux status bar: "user sys #[bg=color] idle"
# Works on macOS and Linux; needs no external tools besides awk.

case "$(uname -s)" in
Darwin)
	# Second sample of `top` gives current usage (the first is since boot)
	cpu_line=$(top -l 2 | grep "CPU usage:" | tail -n 1 | sed 's/CPU usage: //')
	read -r cpu_user cpu_syst cpu_idle < <(
		echo "$cpu_line" | awk '{ gsub("%", ""); print $1, $3, $5 }'
	)
	;;
Linux)
	# Two snapshots of /proc/stat, 0.5 s apart
	# Fields: user nice system idle iowait irq softirq steal ...
	read -r _ u1 n1 s1 i1 w1 q1 sq1 st1 _ </proc/stat
	sleep 0.5
	read -r _ u2 n2 s2 i2 w2 q2 sq2 st2 _ </proc/stat

	du=$(((u2 + n2) - (u1 + n1)))
	ds=$(((s2 + q2 + sq2) - (s1 + q1 + sq1)))
	di=$(((i2 + w2) - (i1 + w1)))
	dt=$(((u2 + n2 + s2 + i2 + w2 + q2 + sq2 + st2) - (u1 + n1 + s1 + i1 + w1 + q1 + sq1 + st1)))

	read -r cpu_user cpu_syst cpu_idle < <(
		awk -v u="$du" -v s="$ds" -v i="$di" -v t="$dt" \
			'BEGIN { if (t <= 0) t = 1; printf "%.1f %.1f %.1f\n", 100*u/t, 100*s/t, 100*i/t }'
	)
	;;
*)
	exit 0
	;;
esac

idle_color=$(awk -v idle="$cpu_idle" \
	'BEGIN { if (idle < 40) print "red"; else if (idle < 70) print "yellow"; else print "green" }')

printf "%4.1f %4.1f #[bg=%s] %4.1f" "$cpu_user" "$cpu_syst" "$idle_color" "$cpu_idle"
exit 0
