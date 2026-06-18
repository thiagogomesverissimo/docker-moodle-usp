### Subindo ambiente

    cd ..
    docker build --no-cache -t moodleusp .
    docker compose up

### Moodle

    git clone git@gitlab.uspdigital.usp.br:atp/uspdb-sync.git
    git clone git@gitlab.uspdigital.usp.br:atp/moodle.git
    cd moodle
    git checkout extensao # edisc
    rm moodle/config.php & docker exec -it moodleusp /install.sh



### sync 

    docker exec -it moodleusp_mariadb bash
    mariadb -uroot moodleusp -pmoodleusp

    Criar a tabela sync_times.sql


    docker exec -it moodleusp bash
    cd uspdb-sync/
    cp config-dist.php config.php # arrumar sybase

    cp config-local-dist.php config-local-dev.php

    $CFG->my_db_name     = 'moodleusp';
    $CFG->my_db_user     = 'moodleusp';
    $CFG->my_db_password = 'moodleusp';
    $CFG->my_db_host     = 'mariadb';


    php sync.php -v -r -d config-local-dev.php turmas_gr turmas_ad_gr turmas_resp_gr alunoturma_gr alunoturma_pos prefixodiscip

    php sync.php -v -r -d config-local-dev.php responsaveledicaoceu colegiadoceu cursoceu edicaocursoofeceu edicaocursoceu modalidcursoceu matriculaatividadeceu atividadeceu atividadeprogramaceu ministranteceu alunoceu matriculacursoceu programacursoceu

    








