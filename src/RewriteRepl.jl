# [[file:~/Documents/Julia/RewriteRepl/README.org::*Source%20Code][Source Code:1]]
module RewriteRepl

using Reexport, ReplMaker
@reexport using Rewrite

Rewrite.normalize(t::Term, tup::Tuple) = normalize(t, tup...)

if isdefined(Base, :active_repl)
     initrepl(
         prompt_text  = "@term> ",
         prompt_color = :cyan, 
         start_key    = '=', 
         mode_name    = "Rewrite_mode",
     ) do s
         exs = [Meta.parse(i) for i in split(s, "with")]
         if length(exs) == 1
             :(normalize((@term $(exs[1]))))
         elseif length(exs) == 2
             :(normalize((@term $(exs[1])), $(exs[2])))
         else
             throw("Only one `with` statement allowed.")
         end
     end
 end

export normalize, Rewrite

end
# Source Code:1 ends here
