public protocol Graph {
    associatedtype Position: Hashable
    associatedtype Cost: Numeric & Comparable = Int

    func neighbors(at postition: Position) -> [Position]
    func cost(from: Position, to: Position) -> Cost
    func distance(from: Position, to: Position) -> Cost
    func isFinished(at: Position, destination: Position) -> Bool
}

public class AStar<Map: Graph> {
    public typealias Position = Map.Position
    typealias Cost = Map.Cost
    private let map: Map

    public init(map: Map) {
        self.map = map
    }

    public func shortestPath(from start: Position, to destination: Position) -> [Position] {
        var queue = PriorityQueue<Node> { $0.fScore < $1.fScore }
        var seen = [Position: Cost]()

        queue.enqueue(Node(position: start))
        seen[start] = 0

        while let currentNode = queue.dequeue() {
            let currentCoordinate = currentNode.position

            if map.isFinished(at: currentCoordinate, destination: destination) {
                var result = [Position]()
                var node: Node? = currentNode
                while let n = node {
                    result.append(n.position)
                    node = n.parent
                }
                return Array(result.reversed().dropFirst())
            }

            for neighbor in map.neighbors(at: currentCoordinate) {
                let moveCost = map.cost(from: currentCoordinate, to: neighbor)
                let newcost = currentNode.gScore + moveCost

                if seen[neighbor] == nil || seen[neighbor]! > newcost {
                    seen[neighbor] = newcost
                    let hScore = map.distance(from: currentCoordinate, to: neighbor)
                    let node = Node(position: neighbor, parent: currentNode, moveCost: moveCost, hScore: hScore)
                    queue.enqueue(node)
                }
            }
        }

        return []
    }

    private class Node: Comparable, CustomDebugStringConvertible {
        let position: Position
        let parent: Node?

        var fScore: Cost { gScore + hScore }
        let gScore: Cost
        let hScore: Cost

        init(position: Position,
             parent: Node? = nil,
             moveCost: Cost = 0,
             hScore: Cost = 0) {
            self.position = position
            self.parent = parent
            self.gScore = (parent?.gScore ?? 0) + moveCost
            self.hScore = hScore
        }

        static func == (lhs: Node, rhs: Node) -> Bool {
            lhs.position == rhs.position
        }

        static func < (lhs: Node, rhs: Node) -> Bool {
            lhs.fScore < rhs.fScore
        }

        var debugDescription: String {
            "position: \(position) g:\(gScore) h:\(hScore) f:\(fScore)"
        }
    }
}
