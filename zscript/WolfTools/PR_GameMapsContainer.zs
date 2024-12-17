class PR_GameMapsContainer
{
    Array<PR_GameMap> gamemaps;

    static PR_GameMapsContainer Create()
    {
        PR_GameMapsContainer container = new("PR_GameMapsContainer");
        return container;
    }

    void AddMap(PR_GameMap gamemap)
    {
        gamemaps.Push(gamemap);
    }
}
