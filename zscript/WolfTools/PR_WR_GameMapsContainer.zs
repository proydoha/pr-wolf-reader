class PR_WR_GameMapsContainer
{
    Array<PR_WR_GameMap> gamemaps;

    static PR_WR_GameMapsContainer Create()
    {
        PR_WR_GameMapsContainer container = new("PR_WR_GameMapsContainer");
        return container;
    }

    void AddMap(PR_WR_GameMap gamemap)
    {
        gamemaps.Push(gamemap);
    }
}
