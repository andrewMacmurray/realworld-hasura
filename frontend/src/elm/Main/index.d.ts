// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        saveUser: {
          subscribe(callback: (data: { id: number; username: string; email: string; token: string; bio: string | null; profileImage: string | null; following: number[] }) => void): void
        }
        logout_: {
          subscribe(callback: (data: null) => void): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: { user: { id: number; username: string; email: string; token: string; bio: string | null; profileImage: string | null; following: number[] } | null };
    }): Elm.Main.App;
  }
}