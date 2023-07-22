open! Core

type t

val scan_parquet : string -> (t, string) result
val scan_parquet_exn : string -> t
val scan_csv : string -> (t, string) result
val scan_csv_exn : string -> t
val to_dot : t -> (string, string) result
val collect : t -> (Data_frame0.t, string) result
val collect_exn : t -> Data_frame0.t
val collect_all : t list -> (Data_frame0.t list, string) result
val collect_all_exn : t list -> Data_frame0.t list
val filter : t -> predicate:Expr.t -> t
val select : t -> exprs:Expr.t list -> t
val with_columns : t -> exprs:Expr.t list -> t
val groupby : ?is_stable:bool -> t -> by:Expr.t list -> agg:Expr.t list -> t
val join : t -> other:t -> on:Expr.t list -> how:Join_type.t -> t

val join'
  :  t
  -> other:t
  -> left_on:Expr.t list
  -> right_on:Expr.t list
  -> how:Join_type.t
  -> t

val concat
  :  ?how:[ `Diagonal | `Vertical | `Vertical_relaxed ]
  -> ?rechunk:bool
  -> ?parallel:bool
  -> t list
  -> t

val melt
  :  ?variable_name:string
  -> ?value_name:string
  -> ?streamable:bool
  -> t
  -> id_vars:string list
  -> value_vars:string list
  -> t

val sort : ?descending:bool -> ?nulls_last:bool -> t -> by_column:string -> t
val limit : t -> n:int -> t
val explode : t -> columns:Expr.t list -> t
val with_streaming : t -> toggle:bool -> t
val schema : t -> (Schema.t, string) result
val schema_exn : t -> Schema.t
