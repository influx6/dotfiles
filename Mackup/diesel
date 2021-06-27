_diesel() {
    local i cur prev opts cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${i}" in
            diesel)
                cmd="diesel"
                ;;
            
            bash-completion)
                cmd+="__bash__completion"
                ;;
            completions)
                cmd+="__completions"
                ;;
            database)
                cmd+="__database"
                ;;
            db)
                cmd+="__db"
                ;;
            drop)
                cmd+="__drop"
                ;;
            generate)
                cmd+="__generate"
                ;;
            help)
                cmd+="__help"
                ;;
            list)
                cmd+="__list"
                ;;
            migration)
                cmd+="__migration"
                ;;
            pending)
                cmd+="__pending"
                ;;
            print-schema)
                cmd+="__print__schema"
                ;;
            redo)
                cmd+="__redo"
                ;;
            reset)
                cmd+="__reset"
                ;;
            revert)
                cmd+="__revert"
                ;;
            run)
                cmd+="__run"
                ;;
            setup)
                cmd+="__setup"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        diesel)
            opts=" -h -V  --locked-schema --help --version --database-url --config-file   migration setup database bash-completion completions print-schema help  db"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        
        diesel__bash__completion)
            opts=" -h -V  --help --version --locked-schema --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__completions)
            opts=" -h -V  --help --version --locked-schema --database-url --config-file  <SHELL> "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__database)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file   setup reset drop help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__database__drop)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__database__help)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__database__reset)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__database__setup)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__db)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file   setup reset drop help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__help)
            opts=" -h -V  --help --version --locked-schema --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file   run revert redo list pending generate help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__generate)
            opts=" -h  --help --locked-schema --version --format --migration-dir --database-url --config-file  <MIGRATION_NAME> "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --format)
                    COMPREPLY=($(compgen -W "sql barrel" -- "${cur}"))
                    return 0
                    ;;
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__help)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__list)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__pending)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__redo)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__revert)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__migration__run)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__print__schema)
            opts=" -o -w -e -b -h -V -s  --only-tables --whitelist --except-tables --blacklist --with-docs --help --version --locked-schema --schema --patch-file --import-types --database-url --config-file  <table-name>... "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --schema)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -s)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --patch-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --import-types)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        diesel__setup)
            opts=" -h -V  --help --version --locked-schema --migration-dir --database-url --config-file  "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --migration-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --database-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

complete -F _diesel -o bashdefault -o default diesel
