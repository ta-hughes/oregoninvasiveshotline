from setuptools import setup, find_packages


VERSION = '1.10.0.dev0'


setup(
    name='psu.oit.arc.oregoninvasiveshotline',
    version=VERSION,
    description='Oregon Invasives Hotline',
    author='PSU - OIT - ARC',
    author_email='consultants@pdx.edu',
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        'django>=1.8.13,<1.9',
        'django-arcutils>=2.10.0',
        'django-bootstrap-form>=3.2.1',
        'django-cloak',
        'django-haystack>=2.4.1',
        'django-local-settings>=1.0a20',
        'django-perms>=1.2.1',
        'django-pgcli',
        'djangorestframework>=3.3.3',
        'elasticsearch>=1.9.0,<2.0.0',
        'Markdown>=2.6.6',
        'Pillow>=3.2.0',
        'psycopg2>=2.6.1',
        'pytz>=2016.4',
    ],
    extras_require={
        'dev': [
            'bpython',
            'coverage',
            'flake8',
            'isort',
            'model_mommy',
            'mommy-spatial-generators',
            'psu.oit.arc.tasks',
        ]
    },
)
