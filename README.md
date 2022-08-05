# My batchfile utils
Batchfile utilities for me

## dhi.bat
Directory bookmarking with fuzzy finder ( directory moving from list & list management )  

require: any interactive filter tool ( like fuzzy finder, default is [Heatseeker][hs] )  
`dhi rm` require: [sd], [rw]  
`dhi edit` require: `%EDITOR%` environment variable ( or set in this bat )
```sh
dhi        # pushd from `cat listfile.txt | fuzzy`
dhi add    # add %cd% (like pwd) to list
dhi rm     # remove %cd% from list
dhi list   # printout directory list file
dhi edit   # edit directory list file
```

## url.bat
URL encode from argument text  

require: nkf, [sd]  
Usage:
```
Usage:
    url [OPTION] <string>
Option:
    -d, --decode   Decode string
    -h, --help     Show this message
```
Example:  
```sh
url あいうえお
# %E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A
echo あいうえお| toarg url
# %E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A

# if using external binary's echo (like uutils/moreutils)
@echo あいうえお| toarg url
```

## rhqd.bat
cd to [rhq] managed directory  

require: [rhq], tr(can replace with sd), cut, any interactive filter tool ( set `%SELCMD%` in/out of this bat )  

## ghs.bat
Github repository searching, printout repo's name & description  
Using Github api, but not support api token yet ( and not planned now )  

require: toenv.bat, url.bat, [sd], [rg], [xq][] ( that is one of jq clone )  
Demo:  

![ScreenShot](https://i.imgur.com/IIgH9Cg.png)

## ghrel.bat
Github release URL getter, use fuzzy finder to select assets  
Specify repository name from arguments ( user/name format )  

These error handling is not good, and behavior is dependent on Heatseeker's that  
( if query is empty, ignore query specify option )  

require: [xq], [teip], [hs], [sd], head ( just in case for my use case, removable )  
Example:  
```sh
ghrel BurntSushi/ripgrep
# ( selecting...)
# https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-pc-windows-msvc.zip

# Set initial selecting query
ghrel BurntSushi/ripgrep msvc
```

## tet.bat
Minimum template expander ( just a replacer )  

require: [sd]  
Example:  
```sh
echo Hi, {{ name }}! | tet name=John
# Hi, John!
```

## toenv.bat
Command output to envvar  
Usage:  
```sh
USAGE:
  toenv var="cmd"
piped command:
  toenv var="cmd1 <args> ^| cmd2"
```

## toarg.bat
Stdin to command arg ( for only oneline )  
If argument is empty, just exec stdin as a command  

Example:  
```sh
echo https://example.com | toarg browser
```

## fuzzyarg.bat
Similar to toarg, but use fuzzy finder for take out single line, from multiline stdin ( experimental )  

## browser.bat
Open URL in firefox private browsing  
Example:  
```sh
browser https://example.com
browser example.com
echo https://example.com | toarg browser
```

## memo.bat
Toy clone of mattn/memo ( not maintained now )  


[sd]: https://github.com/chmln/sd
[rw]: https://github.com/jridgewell/rw
[rhq]: https://github.com/ubnt-intrepid/rhq
[rg]: https://github.com/BurntSushi/ripgrep
[xq]: https://github.com/MiSawa/xq
[teip]: https://github.com/greymd/teip
[hs]: https://github.com/rschmitt/heatseeker
<!-- []: https://github.com/ -->
