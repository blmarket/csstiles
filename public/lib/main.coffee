board = [
  [ ['floor floor_grey_dirt'], ['floor floor_pebble', 'feat dngn_tree_2', 'feat blood'] ]
  [ ['floor floor_demonic_lightgray_7', 'player demon_wings_2', 'player demon_body_5', 'player demon_head_13'], ['feat dngn_tree_2'] ]
]

drawBoard = (board) ->
  table = d3.select('#board').append('table')
  table.attr 'class', 'tile'

  table.selectAll('tr').data(board).enter()
    .append('tr').selectAll('td').data((d) -> d).enter()
    .append('td').selectAll('div').data((d) -> d).enter()
    .append('div').attr 'class', (d) -> d
  return

showTiles = ->
  names = [ 'floor', 'wall', 'feat' ]
  for key in names
    list = tile_list[key]
    t = d3.select('#tiles').append('table')
    t.attr 'class', 'tile'
    t.append('tr').selectAll('td').data(list).enter()
      .append('td').append('div').attr 'class', (d) -> "#{key} #{d}"
  return

angular.module 'csstiles', [ 'ngResource' ]

TilesCtrl = ($scope, $resource) ->
  genBoard = (sx, sy, floors) ->
    len = floors.length

    ret = new Array(sx)
    for i in [0...sx]
      ret[i] = new Array(sy)
      for j in [0...sy]
        ret[i][j] = [ floors[Math.floor(Math.random() * len)] ]
    return ret

  updateBoard = ->
    $scope.board = genBoard(20, 20, [
      'floor floor_grass'
      'floor floor_grass_1'
      'floor floor_grass_2'
      'floor floor_grass_3'
      'floor floor_grass_4'
      'floor floor_grass_5'
      'floor floor_grass_6'
      'floor floor_grass_7'
      'floor floor_grass_8'
      'floor floor_grass_9'
      'floor floor_grass_10'
      'floor floor_grass_11'
    ])
    return

  setSelection = (category, name) -> $scope.curSel = "#{category} #{name}"
  changeCell = (x, y) ->
    return unless $scope.curSel?
    $scope.board[x][y] = [ $scope.curSel ]

  Board = $resource '/1/board' # useless global variable except save/load
  save = ->
    data = new Board { user: 'me', board: $scope.board }
    data.$save()
  load = ->
    board = Board.get { user: 'me' }, ->
      console.log board
      $scope.board = board.board

  $scope.tile_keys = [ 'floor', 'wall', 'feat' ]
  $scope.tile_list = tile_list
  $scope.board = [[[]]]
  $scope.updateBoard = updateBoard
  $scope.curSel = null
  $scope.setSelection = setSelection
  $scope.changeCell = changeCell
  $scope.save = save
  $scope.load = load

  updateBoard()
  return
