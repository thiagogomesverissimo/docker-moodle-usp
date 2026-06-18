Subindo ambiente:

    git clone git@gitlab.uspdigital.usp.br:atp/uspdb-sync.git

    git clone git@gitlab.uspdigital.usp.br:atp/moodle.git
    cd moodle
    git checkout extensao

    cd ..
    docker build --no-cache -t moodleusp .
    docker compose up

    rm moodle/config.php & docker exec -it moodleusp /install.sh

    docker exec -it moodleusp bash
    cd uspdb-sync/
    cp config-dist.php config.php

    $CFG->my_db_name     = 'moodleusp';
    $CFG->my_db_user     = 'moodleusp';
    $CFG->my_db_password = 'moodleusp';
    $CFG->my_db_host     = 'mariadb';


    docker exec -it moodleusp_mariadb bash
    mariadb -uroot moodleusp -pmoodleusp

    Criar a tabela sync_times.sql

    docker exec -it moodleusp bash
    cd uspdb-sync
    php sync.php -v -r all


responsaveledicaoceu colegiadoceu cursoceu edicaocursoofeceu edicaocursoceu modalidcursoceu matriculaatividadeceu atividadeceu atividadeprogramaceu ministranteceu alunoceu matriculacursoceu programacursoceu





