#!/bin/bash
# description: Starts and stops the Oracle listener and database


#Carrega o Profile
source /u01/scripts/profiles/CDBRMSCO.sh

#Variavel para ver se o banco está aberto
net=$(netstat -an | grep LISTEN | grep 1521)

case "$1" in
    'start')
        #Verifica se o Banco está aberto e passa uma mensagem
        if echo "$net" = | grep -q "tcp6.*0.*:::1521.*:::.*LISTEN"; then
            echo "ℹ️ O banco já está em execução. Nenhuma ação necessária."
        else
            #Inicia o Banco
            # Start the listener:
            lsnrctl start

            # Start the databases:
            sqlplus '/ as sysdba' <<'EOF'
                startup
                exit
EOF
        fi
        ;;
    'stop')
        # Stop the listener:
        lsnrctl stop

        # Stop the databases:
        sqlplus '/ as sysdba' <<'EOF'
            shutdown immediate
            exit
EOF
        ;;
    *)
        # Mensagem de erro:
        echo "❌ Por favor, forneça um argumento válido. Use 'start' para iniciar ou 'stop' para parar."
        ;;
esac
