import SwiftUI


class TetrisGameModel: ObservableObject {
    // observe changes so view will update automatically
    var numRows: Int
    var numColumns: Int
    @Published var gameBoard: [[TetrisGameBlock?]]
    @Published var tetromino: Tetromino?
    
    var timer: Timer?
    var speed: Double
    
    
    init(numRows: Int = 23, numColumns: Int = 10) {
        // board construction 
        self.numRows = numRows
        self.numColumns = numColumns
        
        gameBoard = Array(repeating: Array(repeating: nil, count: numRows), count: numColumns)
        tetromino = Tetromino(origin: BlockLocation(row: 22, column: 4), blockType: .i)
        speed = 0.1
    }
    
    func blockClicked(row: Int, column: Int){
        if gameBoard[column][row] == nil {
            gameBoard[column][row] = TetrisGameBlock(blockType: BlockType.allCases.randomElement()!)
        }else{
            gameBoard[column][row] = nil
        }
    }
    
    func resumeGame(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
    }

    func pauseGame(){
        timer?.invalidate()
    }

    func runEngine(timer: Timer){
        // spawn new block
        guard let currentTetromino = tetromino else {
            tetromino = Tetromino(origin: BlockLocation(row: 22, column: 4), blockType: .i)
            return
        }
        
        // move block
        let newTetrimino = currentTetromino.moveBy(row: -1, column: 0)
        if isValidTetremino(testTetromino: newTetrimino){
            tetromino = newTetrimino
            return
        }
        
        // place block
        
        
    }
    func isValidTetremino(testTetromino: Tetromino) -> Bool {
        for block in testTetromino.blocks {
            let row = testTetromino.origin.row + block.row
            if row < 0 || row >= numRows { return false }
            
            let column = testTetromino.origin.column + block.column
            if column < 0 || column >= numColumns { return false }
            
            if gameBoard[column][row] != nil { return false }
        }
        return true
    }
}

struct Tetromino {
    var origin: BlockLocation
    var blockType: BlockType
    
    var blocks:[BlockLocation] {
        [
            BlockLocation(row: 0, column: -1),
            BlockLocation(row: 0, column: 0),
            BlockLocation(row: 0, column: 1),
            BlockLocation(row: 0, column: 2)
        ]
    }
    
    func moveBy(row: Int, column: Int) -> Tetromino {
        let newOrigin = BlockLocation(row: origin.row + row, column: origin.column + column)
        return Tetromino(origin: newOrigin, blockType: blockType)
    }
}

struct BlockLocation {
    var row: Int
    var column: Int
    
}

struct TetrisGameBlock {
    var blockType: BlockType
}

enum BlockType: CaseIterable {
    case i, t, o, j, l, s, z
}
