from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect


def index(request):
        try:
                return render(request, 'app_btrstp_modal/index.html', {
                'var1': 'var_from_front'
                })
        except:
                print('--->- def index exception')
                return render(request, 'app_btrstp_modal/index.html')



def def_two(request):
        pass

