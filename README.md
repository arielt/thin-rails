Simple rails application, for infrastructure testing

## Thin

Thin web server is used instead of webrick, to avoid errors caused by issuing requests to 3rd party servers during rails request processing

## Redis

Redis is quired in App controller

## Fluentd

Rails logs are redirected to fuentd

## StatsD

Rails metrics are sent to StatsD / Graphite
