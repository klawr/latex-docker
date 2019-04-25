:; docker run -i --rm -v "$(pwd):/data" klawr/latex $*; exit $?
@ECHO OFF
docker run -i --rm -v "%cd%:/data" klawr/latex %*