
module Test.Parse_Query(parse_Query) where

import Test.General
import Hoogle.Query.All
import Hoogle.TypeSig.All

parse_Query = do
    let (===) = parseTest parseQuery
        q = blankQuery

    "/info" === q{flags = [Flag "info" ""]}
    "--info" === q{flags = [Flag "info" ""]}
    "/?" === q{flags = [Flag "?" ""]}
    "/count=10" === q{flags = [Flag "count" "10"]}
    "map" === q{names = ["map"]}
    "#" === q{names = ["#"]}
    "c#" === q{names = ["c#"]}
    "-" === q{names = ["-"]}
    "/" === q{names = ["/"]}
    "->" === q{names = ["->"]}
    "foldl'" === q{names = ["foldl'"]}
    "fold'l" === q{names = ["fold'l"]}
    "Int#" === q{names = ["Int#"]}
    "concat map" === q{names = ["concat","map"]}
    "a -> b" === q{typeSig = Just (TypeSig [] (TFun [TVar "a",TVar "b"]))}
    "(a b)" === q{typeSig = Just (TypeSig [] (TApp (TVar "a") [TVar "b"]))}
    "map :: a -> b" === q{names = ["map"], typeSig = Just (TypeSig [] (TFun [TVar "a",TVar "b"]))}
    "+Data.Map map" === q{scope = [PlusModule ["Data","Map"]], names = ["map"]}
    "a -> b +foo" === q{scope = [PlusPackage "foo"], typeSig = Just (TypeSig [] (TFun [TVar "a",TVar "b"]))}
    "a -> b /foo" === q{flags = [Flag "foo" ""], typeSig = Just (TypeSig [] (TFun [TVar "a",TVar "b"]))}
    "a -> b --foo" === q{flags = [Flag "foo" ""], typeSig = Just (TypeSig [] (TFun [TVar "a",TVar "b"]))}
    "Data.Map.map" === q{scope = [PlusModule ["Data","Map"]], names = ["map"]}
    "[a]" === q{typeSig = Just (TypeSig [] (TApp (TLit "[]") [TVar "a"]))}
    "++" === q{names = ["++"]}
    "(++)" === q{names = ["++"]}
