from django.shortcuts import render
from .models import Book


# Create your views here.


def index(request):
    books = Book.objects.all()

    return render(request, "index.html", {"books": books})


def slug(request, id: int):
    book_detail = Book.objects.filter(id=id)[0]

    return render(request, "book_detail.html", {"book": book_detail})
