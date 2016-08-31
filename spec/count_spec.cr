require "./spec_helper"

describe Biocr::Seq::Count do

  it "count DNA Bases" do
    count = Biocr::Seq::Count.bases("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
    count.should eq({'A' => 20, 'G' => 17, 'C' => 12, 'T' => 21})
  end

  it  "Count only ony nucleotide" do
    sequence = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
    count = Biocr::Seq::Count.only('G', sequence)
    count.should eq(17)
  end

end
