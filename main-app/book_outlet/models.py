from django.db import models
from django.core.validators import MinValueValidator, MaxLengthValidator
from django.urls import reverse
from django.utils.text import slugify

# Create your models here.


class Book(models.Model):
    title = models.CharField((""), max_length=50)
    rating = models.IntegerField(
        validators=[MinValueValidator(1), MaxLengthValidator(5)]
    )
    author = models.CharField(max_length=400, null=True)
    is_best_selling_book = models.BooleanField(default=False)
    slug = models.SlugField(default="", null=False)

    def get_absolute_url(self):
        return reverse("book_detail", args=[self.id])

    def __str__(self):
        return f"{self.title}-{self.rating}"

    def save(self, *args, **kwargs):
        self.slug = slugify(self.title)
        super().save(*args, **kwargs)
