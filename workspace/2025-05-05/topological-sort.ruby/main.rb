
def main
    dag = {
        1 => [2, 3],
        2 => [3],
        3 => [],
        4 => [],
    }
    p topological_sort(dag)
end

def topological_sort(dag)
    sorted_keys = []
    visited_keys = []

    dag.keys.each do |key|
        visit(dag, key, visited_keys, sorted_keys)
    end

    sorted_keys
end

def visit(dag, key, visited_keys, sorted_nodes)
    unless visited_keys.include?(key)
        visited_keys << key
        dag[key].each do |key|
            visit(dag, key, visited_keys, sorted_nodes)
        end
        sorted_nodes << key
    end
end

main if $0 == __FILE__

