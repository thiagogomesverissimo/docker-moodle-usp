Subindo ambiente:

    git clone git@gitlab.uspdigital.usp.br:atp/uspdb-sync.git

    git clone git clone git@gitlab.uspdigital.usp.br:atp/moodle.git
    cd moodle
    git checkout extensao

    cd ..
    docker build --no-cache -t moodleusp .
    docker compose up

    rm moodle/config.php & docker exec -it moodleusp /install.sh

