TODO - Adicionar descrição para os comandos abaixo

Instalando dependencias
> pip install -r requirements.txt

Projeto django: https://www.alura.com.br/artigos/django-instalacao-configuracao-e-escrevendo-seu-primeiro-app
Nao entendi o que faz
> python manage.py migrate

Servidor local  - não entendi como funciona
> python manage.py runserver

usuáiro para aplicação - não entendi como funciona
> python manage.py createsuperuser

ou https://docs.djangoproject.com/en/3.0/ref/django-admin/#django-admin-createsuperuser
> Changed in Django 3.0: Support for using DJANGO_SUPERUSER_PASSWORD and DJANGO_SUPERUSER_<uppercase_field_name> environment variables was added.

Carregar dados iniciais
> python manage.py loaddata .\aluraflix\fixtures\programas_iniciais.json

Para resolver pendencias para deploy em "produção"
python manage.py check --deploy

---
## Paths
basepath padrão do django '/admin' e '/'

basepath da aplicação '/programas'


## Docker
> docker build -t aluraflix .

> docker run -it -p 8000:8000 -e DJANGO_SUPERUSER_USERNAME=admin -e DJANGO_SUPERUSER_PASSWORD=admin123@ -e DJANGO_SUPERUSER_EMAIL=admin@example.com aluraflix


