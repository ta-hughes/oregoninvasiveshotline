import os
import site
import sys

here = os.path.dirname(__file__)  # Directory containing this module
root = os.path.dirname(here)      # One level up containing directory

major, minor = sys.version_info[:2]
site_packages = 'lib/python{major}.{minor}/site-packages'.format(**locals())
site_packages = os.path.join(root, '.env', site_packages)

if not os.path.isdir(site_packages):
    raise NotADirectoryError('Could not find virtualenv site-packages at {}'.format(site_packages))

# Add the virtualenv's site-packages to sys.path, ensuring its packages
# take precedence over system packages (by moving them to the front of
# sys.path after they're added).
old_sys_path = list(sys.path)
site.addsitedir(site_packages)
new_sys_path = [item for item in sys.path if item not in old_sys_path]
sys.path = new_sys_path + old_sys_path

os.environ.setdefault('LOCAL_SETTINGS_FILE', os.path.join(root, 'local.cfg'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hotline.settings')

from django.core.wsgi import get_wsgi_application  # noqa
application = get_wsgi_application()
