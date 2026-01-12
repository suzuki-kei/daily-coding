
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
        visit(dag, key, sorted_keys, visited_keys)
    end

    sorted_keys.reverse
end

def visit(dag, key, sorted_keys, visited_keys)
    unless visited_keys.include?(key)
        visited_keys << key
        dag[key].each do |child_key|
            visit(dag, child_key, sorted_keys, visited_keys)
        end
        sorted_keys << key
    end
end

main if $0 == __FILE__

