@rem provided as an example rc.cmd

@>NUL chcp 65001
@"\Program Files (x86)\clink\0.4.9\clink_x64.exe" inject
@cls

@setlocal
@set red=[31m
@set clcl=[0m
@endlocal && set prompt=┌──  %red%%username%@%computername%%red% $_└──  %red%$P$+ →%red%$S

@doskey alias=doskey $*
@doskey ls=dir $*
@doskey cat=type $*
