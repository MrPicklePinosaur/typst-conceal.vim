#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! typst-library = { git = "https://github.com/typst/typst" }
//! ```

use typst_library::prelude::*;
use typst_library::symbols::{emoji, sym};

fn get_symbols(scope: &Scope) {
    for (id, val) in scope.iter() {
        match val {
            Value::Symbol(sym) => {
                for (inner_id, val) in sym.variants() {
                    let full_id: String = if inner_id.is_empty() { id.into() } else { vec![id, inner_id].join(".") };
                    println!("{} {}", full_id, val);
                }
            },
            _ => unreachable!(),
        }
    }
}

fn main() {
    get_symbols(emoji().scope());
    // get_symbols(sym().scope());
}
