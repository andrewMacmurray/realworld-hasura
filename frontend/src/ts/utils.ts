export function safeParse<T>(val: string | null): T | null {
  if (val !== null) {
    try {
      return JSON.parse(val);
    } catch (err) {
      return null;
    }
  } else {
    return null;
  }
}
