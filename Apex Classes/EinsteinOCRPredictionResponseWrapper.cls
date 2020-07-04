public class EinsteinOCRPredictionResponseWrapper {
    
    public String task;
    public ProbabilityWrapper[] probabilities;
    
    public class ProbabilityWrapper {
        public Decimal probability;
        public String label;
        public AttributeWrapper attributes;
    }

    public class AttributeWrapper {
        public String tag;
        public CellLocationWrapper cellLocation;
    }

    public class CellLocationWrapper {
        public Integer rowIndex;
        public Integer colIndex;

    }
}