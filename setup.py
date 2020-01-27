from setuptools import setup, find_packages


VERSION = '1.14.0.dev0'


setup(
    name='psu.oit.arc.oregoninvasiveshotline',
    version=VERSION,
    description='Oregon Invasives Hotline',
    author='PSU - OIT - ARC',
    author_email='webteam@pdx.edu',
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        'pytz',
        'Markdown~=3.2',
        'Pillow~=8.0.1',

        'Django~=2.2.17',
        'psycopg2~=2.8.6',
        'elasticsearch>=2.4.0,<3.0.0',
        'celery~=5.0.5',
        'djangorestframework~=3.12.2',
        'django-bootstrap-form==3.4',
        'django-haystack~=3.0.0',

        'psu.oit.wdt.emcee~=1.0.6',
        'sentry-sdk~=0.19.5',
    ],
    extras_require={
        'dev': [
            'bpython',
            'coverage',
            'flake8',
            'model_mommy',
            'docker-compose'
        ]
    },
    classifiers=[
        'Development Status :: 5 - Production/Stable'
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
    ],
)
