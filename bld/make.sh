export JAVA_HOME=/public/Linux64Software/j2sdk
export ANT_HOME=/public/LinuxSoftware/ant/latest
export PATH=/public/Linux64Software/j2sdk/bin/:/public/LinuxSoftware/ant/latest/bin:$PATH
output_dir=../../pgbsandbox.github.io

usage="USAGE: make.sh dev | rel"
if [ $# -ne 1 ]; then
    echo $usage
    exit 1
fi

if [ $1 = "dev" -o $1 = "rel" ]; then
   mode=$1
else
    echo $usage
    exit 1
fi

if [ ! -f $output_dir/js/edit.js ]; then
    echo "$output_dir is not a valid output destination."
    exit 1
fi

mkdir -p ../out
HELP_TARGET_ROOT_DIR=../out/ HELP_DEV_OR_REL=$mode make
rm -rf $output_dir/$mode
mv ../out/$mode $output_dir
