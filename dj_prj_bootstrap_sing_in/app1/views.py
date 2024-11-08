from django.shortcuts import render


from django.contrib.auth import authenticate, login, logout


from django.http import HttpResponseRedirect
from django.urls import reverse

# Create your views here.
from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect


def index(request):
        try:
                return render(request, 'app1/index.html', {
                'var1': 'var_from_front'
                })
        except:
                print('--->- def index exception')
                return render(request, 'app1/index.html')


def home(request):
        if request.method == "POST":
                # print('--> POST')
                # print('-->', request.POST, type(request.POST))
                usr_nm = request.POST['floatingInput_name']
                usr_ps = request.POST['floatingPassword_name']
                # print('-->', request.POST['floatingInput_name'])
                # print('-->', request.POST['floatingPassword_name'])

                # user = authenticate(request, username = usr_nm, password = usr_ps)
                return render(request, 'app1/home.html')
        else:
                print('-->', request.method)
                return render(request, 'app1/home.html')
