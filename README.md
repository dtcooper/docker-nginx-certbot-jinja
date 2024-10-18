# docker-nginx-certbot-jinja

Thin wrapper on
[Jonas Alfredsson's `nginx-certbot`](https://github.com/JonasAlfredsson/docker-nginx-certbot)
Docker image that adds [Jinja](https://jinja.palletsprojects.com/) templating.


## Usage

By default, reads Jinja template files in `/etc/nginx/templates/*.jinja` and
outputs the result of executing [`jinjanator`](https://github.com/kpfleming/jinjanator)
to `/etc/nginx/conf.d`

_**NOTE:** Environment variables will exist as variables in your Jinja templates,
for example `{{ ENV_VAR_NAME }}` will be valid if your container has
`ENV_VAR_NAME` defined._


## Environment Variables

* `NGINX_JINJA_TEMPLATE_DIR`
  * A directory which contains Jinja template files (default:
    `/etc/nginx/templates`)
  * When this directory doesn't exist, this function will do nothing about
    template processing.

* `NGINX_JINJA_TEMPLATE_SUFFIX`
  * A suffix of template files (default: `.jinja`)
  * This function only processes the files whose name ends with this suffix.

* `NGINX_JINJA_OUTPUT_DIR`
  * A directory where the result of executing envsubst is output (default:
    `/etc/nginx/conf.d`)
  * The output filename is the template filename with the suffix removed.
    * ex.) `/etc/nginx/templates/default.conf.jinja` will be output with the
      filename `/etc/nginx/conf.d/default.conf`.
  * This directory must be writable by the user running a container.


## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT)
&mdash; see the [LICENSE](https://github.com/dtcooper/docker-nginx-certbot-jinja/blob/main/LICENSE)
file for details.
