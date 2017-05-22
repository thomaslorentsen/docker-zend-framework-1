FROM nginx:alpine

MAINTAINER Tom Lorentsen "tom@thomaslorentsen.co.uk"

RUN   apk update \
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates  \
  && wget https://packages.zendframework.com/releases/ZendFramework-1.12.9/ZendFramework-1.12.9-minimal.tar.gz -O /tmp/zf.tar.gz \
  && cd /tmp \
  && tar -zxvf /tmp/zf.tar.gz \
  && cd /tmp/ZendFramework-1.12.9-minimal/library \
  && find . -name '*.php' -not -wholename '*/Loader/Autoloader.php' \
     -not -wholename '*/Application.php' -print0 | \
     xargs -0 sed --regexp-extended --in-place 's/(require_once)/\/\/ \1/g' \
  && mv /tmp/ZendFramework-1.12.9-minimal/library/Zend /usr/local/lib/php