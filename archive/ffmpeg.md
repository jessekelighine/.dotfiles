---
title:  "ffmeg notes"
author: "jessekelighine@gmail.com"
date:   "2024-02-02"
---

# trim mp3

```sh
ffmpeg -i spongebob-foghorn.mp3 -ss 9 -to 51 -c libmp3lame output.mp3
```

# fade-out music

```sh
ffmpeg -i test.mp3 -af "afade=t=out:st=197:d=3" out.mp3
```

# cut the file into 15 minute segments

```sh
ffmpeg -i input.mov -c copy -map 0 -segment_time 00:15:00 -f segment -reset_timestamps 1 teil%02d.mov
```

# join multiple files together

```sh
a=0
for file in *.mov
do
	new=$(printf "original_part%02d.mov" "$a")
	mv -i "$file" "$new"
	let a=a+1
done

ls | sed -E "s/^(.+)$/file '\1'/g" | grep -E '(mov|mp4)' > mylist.txt

mkdir output

ffmpeg -f concat -safe 0 -i mylist.txt -c copy output/output.mp4
ffmpeg -i output/output.mp4 -c copy -map 0 -segment_time 00:15:00 -f segment -reset_timestamps 1 output/part%02d.mp4

rm -rf mylist.txt output/output.mp4
```
