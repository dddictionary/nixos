{
  home.file.".config/graphite/aliases".text = ''
    # Graphite command aliases
    ls log short
    ll log long
    s submit
    ss submit --stack
    m modify
    ma modify --all
    mc modify --commit
    ms modify --submit
    cr create
    c continue
    r restack
    t track
    a add -A
    st state
    sync sync
    top top
  '';
}
