### General

Rules
-For any changes you make, summarize in the changelog.md

## Database changes
After code changes, if changes were done to the `models.py` file,  they are done using `alembic` commands inside the backend container.

Make sure you create a "revision" of your models and that you "upgrade" your database with that revision every time you change them. As this is what will update the tables in your database. Otherwise, your application will have errors.

* Deploy the containers
```console
$ docker compose up -d --build
```

* Start an interactive session in the backend container:

```console
$ docker compose exec backend bash
```

* Alembic is already configured to import your SQLModel models from `./backend/app/models.py`.

* After changing a model (for example, adding a column), inside the container, create a revision, e.g.:

```console
$ alembic revision --autogenerate -m "Add column last_name to User model"
```

* Commit to the git repository the files generated in the alembic directory.

* After creating the revision, run the migration in the database (this is what will actually change the database):

```console
$ alembic upgrade head
```

### Build & Testing
Always run the commands in this order after you are done with any code changes (Exit codes should be 0):

docker compose up -d --build
docker compose exec -d backend bash "scripts/tests-start.sh -x"