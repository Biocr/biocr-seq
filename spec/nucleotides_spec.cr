require "./spec_helper"

include Biocr::Seq

describe Biocr::Seq::Nucleotide do
  describe "Bitwise" do
    (DNA::A | DNA::T).should eq DNA::W
    (DNA::A & DNA::T).should eq DNA::GAP
    (DNA::A == DNA::T).should be_false
    (DNA::A == DNA::A).should be_true
  end
end
