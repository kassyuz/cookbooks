# cookbooks

## Informações

Abaixo seguem informações sobre esse cookbook.

- **Aplicação**: *Apache*
- **Versão**: *2.4.23*
- **Arquitetura**: *x86_64*
- **Processos**: *Download, Compilação, Instalação*
- **Modulos**: *PHP 5 e APR*

## Procedimento

```bash
# Instalação de pré-requisitos
yum install wget gcc pcre-devel openssl-devel -y

# Download do Apache, APR e PHP
wget https://archive.apache.org/dist/httpd/httpd-2.4.23.tar.gz
wget http://mirror.nbtelecom.com.br/apache/apr/apr-1.5.2.tar.gz
wget http://mirror.nbtelecom.com.br/apache/apr/apr-util-1.5.4.tar.gz
wget http://br1.php.net/distributions/php-5.5.38.tar.gz

# Descompactação do Apache e APR
tar xzvf httpd-2.4.23.tar.gz
tar xzvf apr-1.5.2.tar.gz
tar xzvf apr-util-1.5.4.tar.gz
tar zxvf php-5.5.38.tar.gz

# Movendo as dependências para o diretório do Apache
mv apr-1.5.2 apr
mv apr-util-1.5.4 apr-util
mv apr apr-util httpd-2.4.23/srclib/
mv php-5.5.38 php5 httpd-2.4.23/srclib/
mv php5 

# Compilando o Apache
cd httpd-2.4.23/
./configure --enable-ssl --enable-so --enable-proxy --enable-proxy-ajp --enable-proxy-balancer --enable-proxy-connect --enable-proxy-ftp --enable-proxy-http --enable-rewrite --enable-vhost-alias --enable-info --enable-proxy-wstunnel --with-included-apr --with-mpm=event
make

# Instalando o Apache
make install

# Configurações pós-instalação
groupadd apache
useradd -g apache -r apache
chown -R apache:apache /usr/local/apache2/

# Configuração do Apache
sed -i 's/#LoadModule slotmem_shm_module modules\/mod_slotmem_shm.so/LoadModule slotmem_shm_module modules\/mod_slotmem_shm.so/g' /usr/local/apache2/conf/httpd.conf
sed -i 's/#LoadModule ssl_module modules\/mod_ssl.so/LoadModule ssl_module modules\/mod_ssl.so/g' /usr/local/apache2/conf/httpd.conf
sed -i 's/#LoadModule rewrite_module modules\/mod_rewrite.so/LoadModule rewrite_module modules\/mod_rewrite.so/g' /usr/local/apache2/conf/httpd.conf
sed -i 's/#LoadModule php5_module modules\/libphp5.so/LoadModule php5_module modules\/libphp5.so/g' /usr/local/apache2/conf/httpd.conf
sed -i 's/User daemon/User apache/g' /usr/local/apache2/conf/httpd.conf
sed -i 's/Group daemon/Group apache/g' /usr/local/apache2/conf/httpd.conf
sed -i "s/#ServerName www.example.com:80/ServerName $HOSTNAME/g" /usr/local/apache2/conf/httpd.conf


# Inicialização do Apache
/usr/local/apache2/bin/apachectl -k start
```
