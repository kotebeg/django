
#!/bin/bash
var_project_name="dj_prj_bootstrap_modal"
var_app_name="app_btrstp_modal"


django-admin startproject "$var_project_name"

# change directory to: dj_project_selectize
cd "$var_project_name"

python3 manage.py startapp "$var_app_name"


touch "$var_app_name"/urls.py
echo "from django.urls import path" >> "$var_app_name"/urls.py
echo "from . import views"          >> "$var_app_name"/urls.py


mkdir "$var_app_name"/static
mkdir "$var_app_name"/static/"$var_app_name"
mkdir "$var_app_name"/static/"$var_app_name"/css
mkdir "$var_app_name"/static/"$var_app_name"/js

mkdir "$var_app_name"/templates
mkdir "$var_app_name"/templates/includes
mkdir "$var_app_name"/templates/"$var_app_name"


# create html files
touch "$var_app_name"/templates/"$var_app_name"/index.html
echo "it works" >> "$var_app_name"/templates/"$var_app_name"/index.html
touch "$var_app_name"/templates/"$var_app_name"/layout.html


echo '
{% load static %}
<!DOCTYPE html>
<html lang="en">
<head>
    <title>selectize</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

        {% comment %} selectize css {% endcomment %}
        <link rel="stylesheet" href="{% static '"$var_app_name"/selectize/css/selectize.css' %}">

</head>
<body class="text-white bg-dark">
    {% block body %}
    
    
        
    {% endblock %}
</body>

</body>
</html>



'>> "$var_app_name"/templates/"$var_app_name"/layout.html


# routing
echo "
urlpatterns = [
        path('', views.index, name = 'index'),
] 
"       >>"$var_app_name"/urls.py


#  views.py
echo "from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect" >> "$var_app_name"/views.py
echo "" >> "$var_app_name"/views.py

echo "
def index(request):
        try:
                return render(request, '"$var_app_name"/index.html', {
                'var1': 'var_from_front'
                })
        except:
                print('--->- def index exception')
                return render(request, '"$var_app_name"/index.html')

">> "$var_app_name"/views.py

echo "
def def_two(request):
        pass
" >> "$var_app_name"/views.py

cd ..

# creat readme file ------------
touch "$var_project_name"/readme.md
echo  "# django selectize" >> "$var_project_name"/readme.md
# # creat readme file ------------

sed -i "18s/$/, include/" "$var_project_name"/"$var_project_name"/urls.py
sed -i "21a\    path('"$var_app_name"/', include('"$var_app_name".urls'))," "$var_project_name"/"$var_project_name"/urls.py


sed -i "39a\ \t'"$var_app_name"'," "$var_project_name"/"$var_project_name"/settings.py




python3 "$var_project_name"/manage.py runserver


