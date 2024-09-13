(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
 (channel
 (name 'rosenthal)
 (url "https://codeberg.org/hako/rosenthal.git")
 (branch "trunk")
 (introduction
  (make-channel-introduction
   "7677db76330121a901604dfbad19077893865f35"
   (openpgp-fingerprint
    "13E7 6CD6 E649 C28C 3385  4DF5 5E5A A665 6149 17F7")))))
(channel
  (name 'home-service-dwl-guile)
  (url "https://github.com/engstrand-config/home-service-dwl-guile")
  (branch "main")
  (introduction
    (make-channel-introduction
      "314453a87634d67e914cfdf51d357638902dd9fe"
      (openpgp-fingerprint
        "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
