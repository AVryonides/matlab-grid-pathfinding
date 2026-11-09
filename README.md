# MATLAB Grid Pathfinding

Generate an obstacle map, pick a start and goal, and watch a route travel across the grid. The GUI uses breadth-first search (BFS) with one-cell moves in four directions. A separate demo compares BFS with A* on a fixed map.

![BFS and A* return the same route, with many more expanded cells shaded for BFS](docs/screenshots/bfs-vs-astar.png)

Both searches found the same 30-move route on this map. BFS processed 226 cells and A* processed 40. The blue shading shows the cells each search processed, while the red line shows the route it returned. A* uses Manhattan distance and breaks ties by preferring cells closer to the goal.

## Run it

Open the project folder in MATLAB. The project was run with MATLAB R2025a.

1. Run `PathTestWithAlternates` to open the GUI.
2. Set the grid size and obstacle density, then click **Generate Map**.
3. Enter start and goal coordinates as `x,y` and click **Plot Start / End**. Choose free cells for both endpoints.
4. Click **Find Path** to draw the shortest route.
5. Click **Generate Alternative Path** to try a route through a random reachable checkpoint. Use **Select Path** to choose a route, then click **Start Simulation** to animate it. The most recently generated alternative is exported to `alternativePath.csv`.

Run `compareSearches` for the fixed-map comparison pictured above.

## Example runs

| What to look for | Screenshots |
| --- | --- |
| A generated 16×16 map, followed by endpoint selection and the shortest route | [Map](docs/screenshots/occupancy-grid.png) · [Endpoints](docs/screenshots/start-end-markers.png) · [BFS route](docs/screenshots/bfs-shortest-path.png) |
| The first checkpoint attempt repeated the 30-move route. The second produced a distinct 34-move route. | [Repeated route](docs/screenshots/path-2-duplicate.png) · [Distinct route](docs/screenshots/path-3-alternative.png) |
| The simulation follows horizontal and vertical segments and makes right-angle turns. | [On a segment](docs/screenshots/simulation-on-horizontal-segment.png) · [At a turn](docs/screenshots/simulation-at-turn.png) |
| One map at density 0.1 had a 30-move route. On the sampled 0.3 map, obstacles trapped the start. | [0.1 route](docs/screenshots/density-0p1-route.png) · [0.3 map](docs/screenshots/density-0p3-map.png) · [No path dialog](docs/screenshots/density-0p3-no-path-dialog.png) |
| The GUI route used as the baseline for the fixed-map comparison | [BFS baseline](docs/screenshots/bfs-baseline.png) |
