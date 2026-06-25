### Subindo ambiente

    cd ..
    docker build --no-cache -t moodleusp .
    docker compose up

### Moodle

    git clone git@gitlab.uspdigital.usp.br:atp/uspdb-sync.git
    git clone git@gitlab.uspdigital.usp.br:atp/moodle.git
    cd moodle
    git checkout extensao # ou edisc

## Instalação do Moodle 

    rm moodle/config.php & docker exec -it moodleusp /install.sh

    http://localhost:8000
    user: admin
    senha: Admin123!

# extensao

    docker exec -it moodleusp php moodle/admin/cli/cfg.php --name=theme --set=extensao2
    Configurações: /admin/settings.php?section=blocksettingextensao
    OFERECIMENTOATIVIDADECEU será CEPAVIEW_OFERECIMENTOATIVIDADE
    Na configuração de plugins -> blocos -> USP extensão
    docker exec -it moodleusp php moodle/blocks/extensao/cli/sync.php

    docker exec -it -it moodleusp php moodle/admin/cli/scheduled_task.php --execute="\\block_extensao\\task\\sincronizar"


# edisc

    docker exec -it moodleusp php moodle/admin/cli/cfg.php --name=theme --set=edis
    Na configuração de plugins -> blocos -> cursos usp

    


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

Para montar as tabelas alunoturma_moodle e turmas_moodle são usadas SOMENTE as tabelas:

alunoturma_gr alunoturma_pos turmas_gr turmas_ad_gr turmas_resp_gr turmas_pos

Para popular as tabelas alunoturma_moodle e turmas_moodle:

    php sync.php -v -m -d config-local-dev.php



for table in sitalunoativogr unidade unidcoleg cursogr habilitacaogr alunoturma_gr turmas_gr turmas_ad_gr turmas_resp_gr alunoturma_pos turmas_pos unidades prefixodiscip pessoa emailpessoa disciplinas_gr disciplinas_pos vinculopessoausp 
do
	   ( ./sync.php  -v -r -d config-local-prod.php $table 2>&1 | mail -s "uspdb-sync $table" root ) &  
done


    php sync.php -v -r -d config-local-dev.php alunoturma_gr alunoturma_pos turmas_gr turmas_ad_gr turmas_resp_gr turmas_pos

    php sync.php -v -r -d config-local-dev.php responsaveledicaoceu colegiadoceu cursoceu edicaocursoofeceu edicaocursoceu modalidcursoceu matriculaatividadeceu atividadeceu atividadeprogramaceu ministranteceu alunoceu matriculacursoceu programacursoceu

    








