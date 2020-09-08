let graph = AdjacencyList<String>()

let a = graph.createVertex(data: "A")
let b = graph.createVertex(data: "B")
let c = graph.createVertex(data: "C")
let d = graph.createVertex(data: "D")
let e = graph.createVertex(data: "E")

graph.addDirectedEdge(from: a, to: b, weight: nil)
graph.addDirectedEdge(from: a, to: c, weight: nil)
graph.addDirectedEdge(from: c, to: b, weight: nil)
graph.addDirectedEdge(from: c, to: d, weight: nil)
graph.addDirectedEdge(from: d, to: b, weight: nil)
graph.addDirectedEdge(from: a, to: e, weight: nil)
graph.addDirectedEdge(from: e, to: c, weight: nil)

print(graph)


func solution(from source: Vertex<String>, to destination: Vertex<String>) {
    print(find_path(to: destination, from: source))
}
func find_path(to destination: Vertex<String>, from source: Vertex<String>, path: String = "") -> [String] {
    var array: [String] = []
    let _path = path + source.data
    
    if source.data == destination.data {
        return [_path]
    } else {
        for edge in graph.edges(from: source) {
            array.append(contentsOf: find_path(to: destination, from: edge.destination, path: _path))
        }
    }
    
    return array
}

solution(from: e, to: b)
