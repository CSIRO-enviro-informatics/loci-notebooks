# loci-notebooks
Jupyter notebooks for Loc-I

## Quickstart
Using a minimal docker stack (python only)
```
$ docker-compose up -d --build
```
Running `docker-compose logs` should give you the session token to use to login via http://localhost:888

To stop the notebook server:
```
$ docker-compose down -v
```

### R/Python option

You can also run these with R and Python via the datascience Jupyter stack
```
$ docker-compose -f docker-compose.datascience.yml up -d --build
```
Running `docker-compose logs` should give you the session token to use to login via http://localhost:888

To stop the notebook server:
```
$ docker-compose down -v
```
