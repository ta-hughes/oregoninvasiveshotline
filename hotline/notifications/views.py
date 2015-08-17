from django.contrib import messages
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect

from hotline.perms import permissions

from .forms import UserNotificationQueryForm, UserSubscriptionDeleteForm
from .models import UserNotificationQuery


@permissions.is_active
def create(request):
    query = request.GET.urlencode()
    instance = UserNotificationQuery(user=request.user, query=query)
    if request.method == "POST":
        form = UserNotificationQueryForm(request.POST, instance=instance)
        if form.is_valid():
            form.save()
            messages.success(request, "Saved")
            return HttpResponseRedirect(reverse("reports-list") + "?" + request.GET.urlencode())
    else:
        form = UserNotificationQueryForm(instance=instance)

    return render(request, "notifications/create.html", {
        "form": form,
    })

@permissions.is_active
def list_(request):
    subscriptions = UserNotificationQuery.objects.filter(user=request.user)

    if request.method == "POST":
        form = UserSubscriptionDeleteForm(request.POST, user=request.user)
        if form.is_valid():
            form.save()
            return redirect("notifications-list")
    else:
        form = UserSubscriptionDeleteForm(user=request.user)

    return render(request, "notifications/list.html", {
        "form": form,
    })
