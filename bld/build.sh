SOURCE_DIR="$(cd ..; pwd)"
OUTPUT_DIR="$(cd ../../pgbsandbox.github.io; pwd)"
DITA_OTK_ROOT="../../dita-ot-2.5.3"

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

if [ ! -f "$OUTPUT_DIR/js/edit.js" ]; then
    echo "$OUTPUT_DIR is not a valid output destination."
    exit 1
else
    OUTPUT_DIR=$OUTPUT_DIR/$mode
fi

rm -rf "$OUTPUT_DIR"
cd "$DITA_OTK_ROOT"
bin/dita                                                                                  \
         --args.xhtml.contenttarget=contentwin                                            \
         --args.xhtml.toc.xsl=plugins/com.stilo.authorbridge/xsl/map2xhtmltoc-wrapper.xsl \
         --args.xhtml.toc=toc                                                             \
         --args.css=AuthorBridge.css                                                      \
         --args.cssroot="$SOURCE_DIR/build_files"                                         \
         --args.copycss=yes                                                               \
         --args.input="$SOURCE_DIR/DITA/AB.ditamap"                                       \
         --output.dir="$OUTPUT_DIR"                                                       \
         --dita.temp.dir="$OUTPUT_DIR/temp"                                               \
         --transtype=xhtml                                                                \
         --args.indexshow=no                                                              \
  2>&1 | tee log

cp -r "$SOURCE_DIR"/build_files/* "$OUTPUT_DIR"
