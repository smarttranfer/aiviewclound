import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    return
        // Adobe XD layer: 'Path 2109' (shape)
        Container(
            margin: EdgeInsets.only(top: 37.h, bottom: 37.h),
            child: SvgPicture.string(
              logo,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.contain,
            ));
  }
}

const String logo =
    '<svg width="214" height="25" viewBox="0 0 214 25" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0.928 24C0.757333 24 0.597333 23.936 0.448 23.808C0.32 23.6587 0.256 23.4987 0.256 23.328C0.256 23.2 0.266667 23.104 0.288 23.04L7.744 2.528C7.95733 1.90933 8.384 1.6 9.024 1.6H14.016C14.656 1.6 15.0827 1.90933 15.296 2.528L22.752 23.04C22.7733 23.104 22.784 23.2 22.784 23.328C22.784 23.4987 22.7093 23.6587 22.56 23.808C22.432 23.936 22.2827 24 22.112 24H17.952C17.44 24 17.0773 23.7653 16.864 23.296L15.712 20.192H7.328L6.176 23.296C5.96267 23.7653 5.6 24 5.088 24H0.928ZM8.672 15.392H14.368L11.52 7.232L8.672 15.392ZM26.0073 24C25.7939 24 25.6019 23.9253 25.4313 23.776C25.2819 23.6053 25.2073 23.4133 25.2073 23.2V2.4C25.2073 2.16533 25.2819 1.97333 25.4313 1.824C25.6019 1.67467 25.7939 1.6 26.0073 1.6H30.5833C30.8179 1.6 31.0099 1.67467 31.1593 1.824C31.3086 1.97333 31.3833 2.16533 31.3833 2.4V23.2C31.3833 23.4133 31.3086 23.6053 31.1593 23.776C31.0099 23.9253 30.8179 24 30.5833 24H26.0073ZM48.8573 24C48.4946 24 48.1959 23.9147 47.9613 23.744C47.7479 23.552 47.5986 23.3173 47.5133 23.04L41.0493 2.56L40.9853 2.272C40.9853 2.10133 41.0493 1.952 41.1773 1.824C41.3266 1.67467 41.4973 1.6 41.6893 1.6H45.8813C46.2013 1.6 46.4573 1.696 46.6493 1.888C46.8626 2.05867 47.0013 2.25067 47.0653 2.464L51.4173 16.928L55.8013 2.464C55.8653 2.22933 55.9933 2.02667 56.1853 1.856C56.3986 1.68533 56.6653 1.6 56.9853 1.6H61.1773C61.3693 1.6 61.5293 1.67467 61.6573 1.824C61.7853 1.952 61.8493 2.10133 61.8493 2.272C61.8493 2.37867 61.8386 2.47467 61.8173 2.56L55.3213 23.04C55.2573 23.3173 55.1079 23.552 54.8733 23.744C54.6599 23.9147 54.3719 24 54.0093 24H48.8573ZM65.2178 5.056C64.9831 5.056 64.7911 4.98133 64.6418 4.832C64.4924 4.66133 64.4178 4.45867 64.4178 4.224V1.248C64.4178 1.01333 64.4924 0.821332 64.6418 0.671999C64.8124 0.501332 65.0044 0.415998 65.2178 0.415998H69.2178C69.4524 0.415998 69.6444 0.501332 69.7938 0.671999C69.9644 0.821332 70.0498 1.01333 70.0498 1.248V4.224C70.0498 4.45867 69.9644 4.66133 69.7938 4.832C69.6444 4.98133 69.4524 5.056 69.2178 5.056H65.2178ZM65.2178 24C65.0044 24 64.8124 23.9253 64.6418 23.776C64.4924 23.6053 64.4178 23.4133 64.4178 23.2V8.16C64.4178 7.92533 64.4924 7.73333 64.6418 7.584C64.8124 7.43467 65.0044 7.36 65.2178 7.36H69.2178C69.4524 7.36 69.6444 7.43467 69.7938 7.584C69.9644 7.73333 70.0498 7.92533 70.0498 8.16V23.2C70.0498 23.4347 69.9644 23.6267 69.7938 23.776C69.6444 23.9253 69.4524 24 69.2178 24H65.2178ZM81.507 24.32C78.9043 24.32 76.8563 23.6267 75.363 22.24C73.8697 20.832 73.1017 18.7947 73.059 16.128V15.136C73.1443 12.5973 73.9337 10.6133 75.427 9.184C76.9203 7.75467 78.9363 7.04 81.475 7.04C83.3097 7.04 84.8563 7.41333 86.115 8.16C87.395 8.88533 88.3443 9.89867 88.963 11.2C89.603 12.48 89.923 13.9413 89.923 15.584V16.384C89.923 16.6187 89.8377 16.8213 89.667 16.992C89.5177 17.1413 89.3257 17.216 89.091 17.216H78.947V17.408C78.9683 18.368 79.1923 19.1467 79.619 19.744C80.0457 20.32 80.6537 20.608 81.443 20.608C81.955 20.608 82.3603 20.512 82.659 20.32C82.979 20.1067 83.2777 19.84 83.555 19.52C83.747 19.3067 83.8963 19.1787 84.003 19.136C84.131 19.072 84.323 19.04 84.579 19.04H88.771C88.963 19.04 89.123 19.104 89.251 19.232C89.4003 19.3387 89.475 19.4773 89.475 19.648C89.475 20.2027 89.155 20.8533 88.515 21.6C87.8963 22.3467 86.979 22.9867 85.763 23.52C84.5683 24.0533 83.1497 24.32 81.507 24.32ZM84.035 13.952V13.888C84.035 12.864 83.811 12.0747 83.363 11.52C82.915 10.944 82.2857 10.656 81.475 10.656C80.6643 10.656 80.035 10.944 79.587 11.52C79.1603 12.0747 78.947 12.864 78.947 13.888V13.952H84.035ZM96.9648 24C96.6661 24 96.4314 23.936 96.2608 23.808C96.1114 23.6587 95.9941 23.456 95.9088 23.2L91.3008 8.384L91.2368 8.096C91.2368 7.88267 91.3114 7.712 91.4608 7.584C91.6101 7.43467 91.7808 7.36 91.9728 7.36H95.4608C95.7168 7.36 95.9301 7.43467 96.1008 7.584C96.2714 7.712 96.3781 7.86133 96.4208 8.032L99.0448 16.896L101.829 8.096C101.871 7.904 101.978 7.73333 102.149 7.584C102.319 7.43467 102.543 7.36 102.821 7.36H105.029C105.306 7.36 105.53 7.43467 105.701 7.584C105.871 7.73333 105.989 7.904 106.053 8.096L108.837 16.896L111.429 8.032C111.493 7.86133 111.599 7.712 111.749 7.584C111.919 7.43467 112.133 7.36 112.389 7.36H115.877C116.09 7.36 116.261 7.43467 116.389 7.584C116.538 7.712 116.613 7.88267 116.613 8.096C116.613 8.20267 116.602 8.29867 116.581 8.384L111.941 23.2C111.791 23.7333 111.45 24 110.917 24H107.877C107.343 24 106.981 23.7333 106.789 23.2L103.941 14.688L101.061 23.2C100.911 23.7333 100.559 24 100.005 24H96.9648Z" fill="#FD7B38"/><path d="M134.831 24.32C131.78 24.32 129.38 23.584 127.631 22.112C125.903 20.64 124.986 18.4853 124.879 15.648C124.858 15.072 124.847 14.1333 124.847 12.832C124.847 11.5093 124.858 10.5493 124.879 9.952C124.986 7.17867 125.914 5.04533 127.663 3.552C129.434 2.03733 131.823 1.28 134.831 1.28C136.73 1.28 138.426 1.58933 139.919 2.208C141.434 2.82667 142.628 3.72267 143.503 4.896C144.378 6.06933 144.836 7.456 144.879 9.056C144.879 9.248 144.804 9.408 144.655 9.536C144.527 9.664 144.367 9.728 144.175 9.728H139.631C139.332 9.728 139.108 9.67467 138.959 9.568C138.831 9.44 138.714 9.216 138.607 8.896C138.308 7.85067 137.85 7.12533 137.231 6.72C136.634 6.29333 135.834 6.08 134.831 6.08C132.42 6.08 131.172 7.424 131.087 10.112C131.066 10.688 131.055 11.5733 131.055 12.768C131.055 13.9627 131.066 14.8693 131.087 15.488C131.172 18.176 132.42 19.52 134.831 19.52C135.812 19.52 136.612 19.3067 137.231 18.88C137.871 18.4533 138.33 17.728 138.607 16.704C138.692 16.384 138.81 16.1707 138.959 16.064C139.108 15.936 139.332 15.872 139.631 15.872H144.175C144.367 15.872 144.527 15.936 144.655 16.064C144.804 16.192 144.879 16.352 144.879 16.544C144.836 18.144 144.378 19.5307 143.503 20.704C142.628 21.8773 141.434 22.7733 139.919 23.392C138.426 24.0107 136.73 24.32 134.831 24.32ZM148.625 24C148.39 24 148.187 23.9253 148.017 23.776C147.867 23.6267 147.793 23.4347 147.793 23.2V2.08C147.793 1.84533 147.867 1.65333 148.017 1.504C148.187 1.35467 148.39 1.28 148.625 1.28H152.625C152.859 1.28 153.051 1.35467 153.201 1.504C153.35 1.65333 153.425 1.84533 153.425 2.08V23.2C153.425 23.4133 153.35 23.6053 153.201 23.776C153.051 23.9253 152.859 24 152.625 24H148.625ZM165.074 24.32C162.386 24.32 160.317 23.7013 158.866 22.464C157.437 21.2053 156.658 19.424 156.53 17.12C156.509 16.8427 156.498 16.3627 156.498 15.68C156.498 14.9973 156.509 14.5173 156.53 14.24C156.658 11.9787 157.458 10.2187 158.93 8.96C160.423 7.68 162.471 7.04 165.074 7.04C167.677 7.04 169.714 7.68 171.186 8.96C172.679 10.2187 173.49 11.9787 173.618 14.24C173.661 14.7947 173.682 15.2747 173.682 15.68C173.682 16.0853 173.661 16.5653 173.618 17.12C173.49 19.424 172.701 21.2053 171.25 22.464C169.821 23.7013 167.762 24.32 165.074 24.32ZM165.074 20.288C165.949 20.288 166.599 20.0213 167.026 19.488C167.453 18.9333 167.698 18.0907 167.762 16.96C167.783 16.7467 167.794 16.32 167.794 15.68C167.794 15.04 167.783 14.6133 167.762 14.4C167.698 13.2907 167.453 12.4587 167.026 11.904C166.599 11.3493 165.949 11.072 165.074 11.072C164.199 11.072 163.549 11.3493 163.122 11.904C162.695 12.4587 162.45 13.2907 162.386 14.4L162.354 15.68L162.386 16.96C162.45 18.0907 162.695 18.9333 163.122 19.488C163.549 20.0213 164.199 20.288 165.074 20.288ZM182.842 24.32C180.965 24.32 179.45 23.6907 178.298 22.432C177.146 21.1733 176.57 19.392 176.57 17.088V8.16C176.57 7.92533 176.645 7.73333 176.794 7.584C176.965 7.43467 177.157 7.36 177.37 7.36H181.626C181.861 7.36 182.053 7.43467 182.202 7.584C182.373 7.73333 182.458 7.92533 182.458 8.16V16.896C182.458 18.88 183.344 19.872 185.114 19.872C185.968 19.872 186.629 19.616 187.098 19.104C187.589 18.5707 187.834 17.8347 187.834 16.896V8.16C187.834 7.92533 187.909 7.73333 188.058 7.584C188.229 7.43467 188.432 7.36 188.666 7.36H192.89C193.125 7.36 193.317 7.43467 193.466 7.584C193.616 7.73333 193.69 7.92533 193.69 8.16V23.2C193.69 23.4133 193.616 23.6053 193.466 23.776C193.317 23.9253 193.125 24 192.89 24H188.986C188.752 24 188.549 23.9253 188.378 23.776C188.229 23.6267 188.154 23.4347 188.154 23.2V21.984C187.045 23.5413 185.274 24.32 182.842 24.32ZM203.564 24.32C201.495 24.32 199.863 23.6693 198.668 22.368C197.495 21.0667 196.865 19.2107 196.78 16.8L196.748 15.68L196.78 14.528C196.865 12.2027 197.505 10.3787 198.7 9.056C199.895 7.712 201.516 7.04 203.564 7.04C205.484 7.04 207.031 7.65867 208.204 8.896V2.08C208.204 1.84533 208.279 1.65333 208.428 1.504C208.599 1.35467 208.791 1.28 209.004 1.28H213.132C213.367 1.28 213.559 1.35467 213.708 1.504C213.879 1.65333 213.964 1.84533 213.964 2.08V23.2C213.964 23.4347 213.879 23.6267 213.708 23.776C213.559 23.9253 213.367 24 213.132 24H209.324C209.111 24 208.919 23.9253 208.748 23.776C208.599 23.6053 208.524 23.4133 208.524 23.2V22.208C207.372 23.616 205.719 24.32 203.564 24.32ZM205.42 19.872C206.337 19.872 207.02 19.584 207.468 19.008C207.916 18.4107 208.161 17.664 208.204 16.768C208.247 16.1707 208.268 15.7653 208.268 15.552C208.268 15.3173 208.247 14.9227 208.204 14.368C208.161 13.536 207.905 12.8533 207.436 12.32C206.988 11.7653 206.316 11.488 205.42 11.488C204.46 11.488 203.767 11.776 203.34 12.352C202.935 12.9067 202.7 13.6853 202.636 14.688L202.604 15.68L202.636 16.672C202.7 17.6747 202.935 18.464 203.34 19.04C203.767 19.5947 204.46 19.872 205.42 19.872Z" fill="white"/></svg>';
