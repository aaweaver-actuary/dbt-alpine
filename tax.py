@dataclass
class Tax:
    fairfield: float
    cincinnati: float
    norwood: float

    def total(self):
        return self.fairfield + self.cincinnati + self.norwood

    def print(self):
        print("Total: ${:,.2f}".format(self.total()))

income23 = Tax(74452.66, 74366.78, 0)
income22 = Tax(74452.66, 76485.44, 0)
