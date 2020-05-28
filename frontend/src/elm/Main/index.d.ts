// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        saveUser: {
          subscribe(callback: (data: { username: string; email: string; token: string }) => void): void
        }
        logout_: {
          subscribe(callback: (data: null) => void): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: { user: { username: string; email: string; token: string } | null };
    }): Elm.Main.App;
  }
}