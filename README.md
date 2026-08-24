<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h2 align="center">FDS - DB </h2> <br />
</p>


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#references">References</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#project-structure">Project structure</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

This Database for DAPEN.


<!-- BUILD WITH -->
#### Built With

* [PostgreSQL](https://www.postgresql.org/)
* [goose](https://github.com/pressly/goose/)


<!-- REFERENCES -->
#### References
* [Youtube](https://www.youtube.com/watch?v=7p_6YDKOxXM)
* [Doc](https://blog.wittcode.com/blogs/connect-grafana-to-postgres-with-docker-compose)
* [ChatGPT](https://chatgpt.com/c/6701db2d-c870-8000-9beb-ccc32ffc11c1)



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.


<!-- PREREQUISITES -->
#### Prerequisites

* I use macOS Sonoma 14.6.1 (23G93)
  ```sh
  ❯ uname -a
  Darwin Kernel Version 23.6.0
   ```
* And then you need to install [goose](https://github.com/pressly/goose/)
    ```sh
    ❯ brew install goose
    ❯ goose --version
    goose version: v3.22.0
   ```


<!-- INSTALLATION -->
## Installation

#### Create the SQL command
1. Add configuration on ~/.zshrc
  ```sh
  ❯ cat ~/.zshrc  | grep -E '^.*GOOSE.*$'
    export GOOSE_DRIVER=postgres
    export GOOSE_DBSTRING="host=192.168.18.51 port=5432 user=checklist password=checklist*164 dbname=checklist sslmode=disable" 
   ```
2. Creating sql command
  ```sh
  ❯ goose dir "./migrations" -s create test sql
  ```

#### Running migration
1. run the migration
  ```sh
  ❯ cd ${PWD}/data/devops/database/checklist-db/migrations
  ❯ goose up
  ``` 
2. drop all migration
  ```sh
  ❯ goose down-to 0
   ```

<!-- Project structure -->
## Project Structure

```sh
.
.
├── CHANGELOG.md
├── README.md
├── kamus.md
├── makefile
├── migrations
│   ├── 20250000000010_schemas.sql
│   ├── 20250000000020_sec_params.sql
│   ├── 20250000000030_sec_master_menu.sql
│   ├── 20250000000040_sec_detail_menu.sql
│   ├── 20250000000050_sec_login_method.sql
│   ├── 20250000000060_sec_permission.sql
│   ├── 20250000000070_utl_generate_id.sql
│   ├── 20250000000080_mst_perusahaan.sql
│   ├── 20250000000090_sec_user.sql
│   ├── 20250000000100_sec_role.sql
│   ├── 20250000000110_sec_user_role.sql
│   └── 20250000000120_sec_rbac.sql
├── script_backup
└── script_restore

2 directories, 18 files
```
