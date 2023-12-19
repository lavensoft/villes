class MPlayerStats {
  int energy = 0;

  MPlayerStats({ this.energy = 0 });

  toMap() => {
    "energy": energy //!TODO: REMOVE NULL FIELD
  };

  MPlayerStats fromMap(Map data) {
    energy = data["energy"] ?? 0;

    return this;
  }
}