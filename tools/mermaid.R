# flow chart ####
library(DiagrammeR)
mermaid("
graph TB
   B(new_classTreeRingShape)
   B --> C(TreeRingPoints  )
   C-->D(TreeRingLines)
   D--> E(TreeRingInterpolation)
   E-->G(TR)
   H(TreeRingShape)-->G
   G-->I(TreeRingArea)
   I-->K(TreeRingIndex)
")

####




# Create a sequence diagram
DiagrammeR("
sequenceDiagram;
   customer->>ticket seller: ask for a ticket;
   ticket seller->>database: seats;
   alt tickets available
     database->>ticket seller: ok;
     ticket seller->>customer: confirm;
     customer->>ticket seller: ok;
     ticket seller->>database: book a seat;
     ticket seller->>printer: print a ticket;
   else sold out
     database->>ticket seller: none left;
     ticket seller->>customer: sorry;
   end
")

# grVitz ####
grViz("digraph{

      graph[rankdir = LR]

      node[shape = rectangle, style = filled]

      node[fillcolor = Coral, margin = 0.2]
      A[label = 'Figure 1: Map']
      B[label = 'Figure 2: Metrics']

      node[fillcolor = Cyan, margin = 0.2]
      C[label = 'Figures.Rmd']

      node[fillcolor = Violet, margin = 0.2]
      D[label = 'Analysis_1.R']
      E[label = 'Analysis_2.R']

      subgraph cluster_0 {
        graph[shape = rectangle]
        style = rounded
        bgcolor = Gold

        label = 'Data Source 1'
        node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
        F[label = 'my_dataframe_1.csv']
        G[label = 'my_dataframe_2.csv']
      }

      subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = Gold

         label = 'Data Source 2'
         node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
         H[label = 'my_dataframe_3.csv']
         I[label = 'my_dataframe_4.csv']
      }

      edge[color = black, arrowhead = vee, arrowsize = 1.25]
      C -> {A B}
      D -> C
      E -> C
      F -> D
      G -> D
      H -> E
      I -> E
      A -> I

      }")
####
