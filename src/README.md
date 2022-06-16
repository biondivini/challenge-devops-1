### Índice  
[Rodando local](#rodando-local)  
[Rodando em container](#rodando-em-container)  


## Rodando Local
#### Step 1 - Instalar dependências do projeto

    pip install -r requirements.txt

#### Step 2 - Inicializar projeto django

Ref: https://www.alura.com.br/artigos/django-instalacao-configuracao-e-escrevendo-seu-primeiro-app

#### 2.1 Cria banco de dados SQLite3 com o modelo declarado no projeto

    python manage.py migrate

#### 2.2 Carregar dados iniciais
    
    python manage.py loaddata .\aluraflix\fixtures\programas_iniciais.json

#### 2.3 usuáiro para aplicação - não entendi como funciona

    python manage.py createsuperuser

> Também pode ser utilizando variavel de ambiente como alternativa para não precisar de ação manual, com a flag `--no-input` . Ref: https://docs.djangoproject.com/en/3.0/ref/django-admin/#django-admin-createsuperuser

#### Step 3 - Rodar aplicação em servidor local
    
    python manage.py runserver

> Para subida em produção é necessário avaliar os avisos declarados ao executar `python manage.py check --deploy`, pois apontam principalmente questões de segurança da aplicação.

> Outro ponto importante para implantação em produção é necessáiro trocar a implementação de servidor de aplicação web do django para algo mais robusto como Gunicorn. Neste link [dockerizing a python django web application](https://semaphoreci.com/community/tutorials/dockerizing-a-python-django-web-application), além do servidor de aplicação, o autor implementa um proxy reverso para servir conteudo estático o que também pode ser interessante para reduzir a carga de requisições que chega no Gunicorn. 

## Rodando em container
    docker run -it -p 8000:8000 -e DJANGO_SUPERUSER_USERNAME=admin -e DJANGO_SUPERUSER_PASSWORD=admin123@ -e DJANGO_SUPERUSER_EMAIL=admin@example.com aluraflix


## Paths da aplicação
A aplicação implementa o [defaultRouter](https://www.django-rest-framework.org/api-guide/routers/#defaultrouter) implementando apenas `{prefix}/` o que significa que disponibiliza metodos HTTP como GET e POST por padrão.

---
    GET /programas?tipo={S ou F}
    [
        {
            "titulo": "titulo",
            "tipo": "F",
            "data_lancamento": "YYYY-MM-DD",
            "likes": 0
        }
    ]
---

    POST /programas

    {
        "titulo": "titulo",
        "tipo": "F",
        "data_lancamento": "YYYY-MM-DD",
        "likes": 0
    }
